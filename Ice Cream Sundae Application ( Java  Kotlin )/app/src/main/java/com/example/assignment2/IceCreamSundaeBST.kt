package com.example.assignment2

import kotlin.properties.Delegates

class IceCreamSundaeBST {

    private var root:Node? = null;
    private lateinit var listItems:String;

    class Node{

        lateinit var item:String;
        var price by Delegates.notNull<Double>();
        var left:Node? = null
        var right:Node? = null

        override fun toString(): String {

            return this.item + " : " + this.price;
        }
    }

    private fun createNode(item:String, price:Double):Node{

        var node:Node = Node();
        node.item = item;
        node.price = price;
        /*node.left;
        node.right;*/

        return node;
    }


    // ADD ITEM
    fun addItem(item:String, price:Double){

        if( root == null ){

            root = createNode(item, price);
        }

        addItemPrivate(root!!, item.lowercase().trim(), price)

    }

    private fun addItemPrivate(holdRoot:Node, item:String, price:Double){

/*        holdRoot ?:  createNode(item, price);

        println("WILL BE PRINTING")

        if( item < holdRoot.item ){

            addItemPrivate(holdRoot.left, item, price);

        }else if( item > holdRoot.item ){

            addItemPrivate(holdRoot.right, item, price);
        }*/

        if( item < holdRoot.item ){

            if (holdRoot.left == null) {
                holdRoot.left = createNode(item, price)

            } else {
                addItemPrivate(holdRoot.left!!, item, price)
            }

        }else if( item > holdRoot.item ){

            if (holdRoot.right == null) {
                holdRoot.right = createNode(item, price)

            } else {
                addItemPrivate(holdRoot.right!!, item, price)
            }
        }

    }

    // REMOVE ITEM
    fun removeItem(item:String){

        this.root?.let { removeItemPrivate(it,item.lowercase().trim()) };
    }

    private fun removeItemPrivate(holdRoot: Node, item: String){


    }

    // FIND ITEM
    fun findItem(item:String): Boolean? {

        var holdRoot: Node? = this.root;
        return holdRoot?.let { findItemPrivate(it, item.lowercase().trim()) }
    }


    private fun findItemPrivate(holdRoot: Node, item:String): Boolean? {

/*        if( holdRoot == null ){

            return false;

        }else if( holdRoot.item.equals(item) ){

            return true;
        }else if( holdRoot.item < item ){

            return holdRoot.left?.let { findItemPrivate(it, item) }

        }else{

            return holdRoot.right?.let { findItemPrivate(it, item) }

        }*/

        if (item < holdRoot.item && holdRoot.left !=null) {
            return findItemPrivate(holdRoot.left!!, item)
        }
        if(item > holdRoot.item && holdRoot.right!=null) {
            return findItemPrivate(holdRoot.right!!, item)
        }
        return item==holdRoot.item

    }

    // GET ITEM
    fun getItem(item:String): Node? {

        var holdRoot: Node? = this.root;

        return holdRoot?.let { getItemPrivate(it, item.lowercase().trim()) }
    }

    private fun getItemPrivate(holdRoot: Node, item:String): Node? {

        if (item < holdRoot.item && holdRoot.left !=null) {
            return getItemPrivate(holdRoot.left!!, item)
        }
        if(item > holdRoot.item && holdRoot.right!=null) {
            return getItemPrivate(holdRoot.right!!, item)
        }
        return holdRoot

    }

    // UPDATE
    fun updateItem(item:String, update:String):Boolean{

        var itemFound:Boolean = findItem(item) == true;
        var theItem = getItem(item);
        if( itemFound && theItem != null ){

            theItem.item = update;
            return true;
        }

        return false;
    }

    fun updateItemAndPrice(item:String, update:String, price:Double): Boolean {

        var itemFound:Boolean = findItem(item) == true;
        var theItem = getItem(item);
        if( itemFound && theItem != null ){

            theItem.item = update;
            theItem.price = price;
            return true;
        }

        return false;

    }

    fun updatePrice(item:String, price:Double): Boolean {

        var itemFound:Boolean = findItem(item) == true;
        var theItem = getItem(item);
        if( itemFound && theItem != null ){

            theItem.price = price;
            return true;
        }

        return false;
    }

    // RESET PRICE
    fun resetPrice(){

        var holdRoot: Node? = this.root;
        resetPricePrivate(holdRoot)
    }

    private fun resetPricePrivate(holdRoot: Node?){

        if( holdRoot == null ){
            return;
        }

        resetPricePrivate(holdRoot.left)
        holdRoot.price = 0.0
        resetPricePrivate(holdRoot.right)
    }

    // get items
    fun getItemsList():String{

        listItems = "";
        var holdRoot: Node? = this.root;
        getItemsListPrivate(holdRoot);

        return this.listItems;
    }

    private fun getItemsListPrivate(holdRoot: Node?) {

        if( holdRoot == null ){
            return;
        }

        getItemsListPrivate(holdRoot.left)
        println("${holdRoot.item} : ${holdRoot.price} \n")
        listItems = "{\n" +
                "${holdRoot.item} : ${holdRoot.price} \n" +
                "}"
        getItemsListPrivate(holdRoot.right)

    }

    override fun toString(): String {
        return getItemsList();
    }
}

