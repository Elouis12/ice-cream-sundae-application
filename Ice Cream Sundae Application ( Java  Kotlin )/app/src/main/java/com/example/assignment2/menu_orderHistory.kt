package com.example.assignment2

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.widget.ArrayAdapter
import kotlinx.android.synthetic.main.activity_menu_about.*
import kotlinx.android.synthetic.main.activity_menu_order_history.*

class menu_orderHistory : AppCompatActivity() {

    var orderHistory = ArrayList<String>();
    var orderHistoryString = ArrayList<String>();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_order_history)

        supportActionBar!!.title = "Order History"
        supportActionBar!!.setDisplayHomeAsUpEnabled(true);

        val orderIntent = intent;

        orderHistory = orderIntent.getSerializableExtra("orderHistory") as ArrayList<String>;

        println("IN ORDER HISTORY")
        println(orderHistory)

        for( order in orderHistory ){

            orderHistoryString.add(order);
        }

        var adapter = ArrayAdapter<String>(this@menu_orderHistory, android.R.layout.simple_list_item_1, orderHistoryString )

        listview_orderHistory.adapter = adapter;

//        text_orderHistory.text = orderHistoryString.toString();

    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        when( item.itemId ){

            android.R.id.home ->{

                this.finish();
                return true;
            }
        }

        return true;
    }
}