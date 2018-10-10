package controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class AddAdvertise extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("text/html;charset=UTF-8");

        try {
            String detail = request.getParameter("detail");

            String rootPath = getServletContext().getRealPath("/");
            String destPath = rootPath + "assets" + File.separator + "images" + File.separator + "advertise";
            Connection conn = (Connection) getServletContext().getAttribute("connection");
            int uid = (int) request.getSession().getAttribute("uid");
            Part img = request.getPart("image");
            String img_name = Paths.get(img.getSubmittedFileName()).getFileName().toString();
            String img_link = "assets/images/advertise/" + img_name;

            // Add image file
            InputStream imgFile = img.getInputStream();
            File file = new File(destPath, img_name);
            Files.copy(imgFile, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            // Add advertise to DB
            String sql = "INSERT INTO advertises (detail,picture_link) VALUES ('" + detail + "','" + img_link + "')";
            PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            int aid = 0;
            if (rs.next()) {
                aid = rs.getInt(1);
            }
            // Add admin_advertise
            Statement stmt = conn.createStatement();
            stmt.executeUpdate("INSERT INTO admin_advertise VALUES (" + uid + "," + aid + ")");
            response.sendRedirect("manageadvertise.jsp");
        } catch (IOException | SQLException | ServletException ex) {
            Logger.getLogger(AddAdvertise.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
