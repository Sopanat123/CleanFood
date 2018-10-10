package model;

import java.util.LinkedList;

public class Cart {

    /**List of the item (linked-list) */
    private LinkedList<CartItem> items;
    /**A summarized price of all item in this current order */
    private float totalPrice;
    /**Total non-discount price */
    private float totalOriPrice;

    /**Hold all of the item currently in purchase session */
    public Cart() {
        this.items = new LinkedList<>();
    }

    /**Add an item as a 'food' into the cart.
     * @param id
     * @param name
     * @param ori_price
     * @param price
     * @param food_type define food type such as salad, seafood, etc.
     * @param meat
     * @param sauce
     * @param ingredient */
    public void addFood(int id, String name, float ori_price, float price, String food_type, 
            String meat, String sauce, String ingredient) {
        CartItem food = new CartItem();
        food.setId(id);
        food.setName(name);
        food.setOri_price(ori_price);
        food.setPrice(price);
        food.setMenu_type("food");
        food.setFood_type(food_type);
        food.setMeat(meat);
        food.setSauce(sauce);
        food.setIngredient(ingredient);
        items.add(food);
        totalPrice += price;
        totalOriPrice += ori_price;
    }

    /**Add an item as an 'appetizer' into the cart.
     * @param id
     * @param name
     * @param ori_price
     * @param price */
    public void addAppetizer(int id, String name,float ori_price, float price) {
        CartItem apt = new CartItem();
        apt.setId(id);
        apt.setName(name);
        apt.setOri_price(ori_price);
        apt.setPrice(price);
        apt.setMenu_type("appetizer");
        items.add(apt);
        totalPrice += price;
        totalOriPrice += ori_price;
    }

    /**Add an item as a 'drink' into the cart
     * @param id
     * @param name
     * @param ori_price
     * @param price */
    public void addDrink(int id, String name,float ori_price, float price) {
        CartItem drk = new CartItem();
        drk.setId(id);
        drk.setName(name);
        drk.setOri_price(ori_price);
        drk.setPrice(price);
        drk.setMenu_type("drink");
        items.add(drk);
        totalPrice += price;
        totalOriPrice += ori_price;
    }

    /**Remove an item from this cart. By doing this, the total price of this cart 
     * will be automatically adjusts.
     * @param index the index number of this item in the list */
    public void removeItem(int index) {
        totalPrice -= items.get(index).getPrice();
        totalOriPrice -= items.get(index).getOri_price();
        items.remove(index);
    }

    /**Remove every item from the cart. */
    public void clearCart() {
        totalPrice = 0;
        totalOriPrice = 0;
        items.clear();
    }

    public LinkedList<CartItem> getItems() {
        return items;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public float getTotalOriPrice() {
        return totalOriPrice;
    }
}
