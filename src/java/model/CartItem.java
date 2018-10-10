package model;

public class CartItem {

    /**identifier number in database */
    private int id;
    /**menu name of this item */
    private String name;
    /**original price for this item, if this item has discount */
    private float ori_price;
    /**price of this item */
    private float price;
    /**define this item as a/an food, appetizer, or a drink */
    private String menu_type;
    /**define what type of this food */
    private String food_type;
    /**define a type of meat of this item. If this item is a food */
    private String meat;
    /**name of the selected sauce of this menu */
    private String sauce;
    /**name of the selected ingredient of this */
    private String ingredient;

    /**Represent the menu for put into cart. Store only useful information that
     * will be put into Order table in database. */
    public CartItem() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getOri_price() {
        return ori_price;
    }

    public void setOri_price(float ori_price) {
        this.ori_price = ori_price;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getMenu_type() {
        return menu_type;
    }

    public void setMenu_type(String menu_type) {
        this.menu_type = menu_type;
    }

    public String getFood_type() {
        return food_type;
    }

    public void setFood_type(String food_type) {
        this.food_type = food_type;
    }

    public String getMeat() {
        return meat;
    }

    public void setMeat(String meat) {
        this.meat = meat;
    }

    public String getSauce() {
        return sauce;
    }

    public void setSauce(String sauce) {
        this.sauce = sauce;
    }

    public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

}
