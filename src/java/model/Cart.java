package model;

import java.util.LinkedList;
import java.util.List;

public class Cart {

    /**List of the item (linked-list) */
    private List<Item> items;
    /**A summarized price of all item in this current order */
    private float totalprice=0;

    /**Hold all of the item currently in purchase session */
    public Cart() {
        this.items = new LinkedList<>();
    }

    /**Add an item as a 'food' into the cart.
     * @param id
     * @param name
     * @param price
     * @param food_type define food type such as salad, seafood, etc.
     * @param meat
     * @param sauce
     * @param ingredient */
    public void addFood(int id, String name, float price, String food_type, 
            String meat, String sauce, String ingredient) {
        Item food = new Item();
        food.setId(id);
        food.setName(name);
        food.setPrice(price);
        food.setMenu_type("food");
        food.setFood_type(food_type);
        food.setMeat(meat);
        food.setSauce(sauce);
        food.setIngredient(ingredient);
        items.add(food);
        totalprice += price;
    }

    /**Add an item as an 'appetizer' into the cart.
     * @param id
     * @param name
     * @param price */
    public void addAppetizer(int id, String name, float price) {
        Item apt = new Item();
        apt.setId(id);
        apt.setName(name);
        apt.setPrice(price);
        apt.setMenu_type("appetizer");
        items.add(apt);
        totalprice += price;
    }

    /**Add an item as a 'drink' into the cart
     * @param id
     * @param name
     * @param price */
    public void addDrink(int id, String name, float price) {
        Item drk = new Item();
        drk.setId(id);
        drk.setName(name);
        drk.setPrice(price);
        drk.setMenu_type("drink");
        items.add(drk);
        totalprice += price;
    }

    /**Remove an item from this cart. By doing this, the total price of this cart 
     * will be automatically adjusts.
     * @param index the index number of this item in the list */
    public void removeItem(int index) {
        totalprice -= items.get(index).getPrice();
        items.remove(index);
    }

    /**Remove every item from the cart. */
    public void clearCart() {
        items.clear();
    }

    public List<Item> getItems() {
        return items;
    }

    public float getTotalprice() {
        return totalprice;
    }
}
