package com.example.assignment2

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.Layout
import android.view.Menu
import android.view.MenuItem
import android.view.View
import android.widget.*
import kotlinx.android.synthetic.main.activity_main.*
import kotlinx.android.synthetic.main.activity_main.view.*
import java.text.NumberFormat
import java.util.*
import kotlin.collections.ArrayList
import kotlin.properties.Delegates


/*internal enum class Flavors { VANILLA, CHOCOLATE, STRAWBERRY }
internal enum class Size { SMALL, MEDIUM, LARGE }*/

class MainActivity : AppCompatActivity() {

    // spinner option for ice cream
    var iceCreamFlavors = ArrayList<String>()

    // spinner option for ice cream size
    var iceCreamSize = ArrayList<String>()

    // hold checkboxes to deselect
    var checkboxArray = ArrayList<CheckBox>();

    // holds string of each order details
    var orderHistory = arrayListOf<String>();

    lateinit var orderString:String;


    var total by Delegates.notNull<Double>();

    lateinit var numberFormat:NumberFormat;

    private var iceCream: IceCreamSundaeBST = IceCreamSundaeBST();

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        numberFormat = NumberFormat.getCurrencyInstance()

        iceCream.addItem("peanuts", 0.15)
        iceCream.addItem("m&ms", 0.25)
        iceCream.addItem("almonds", 0.15)
        iceCream.addItem("brownie", 0.20)
        iceCream.addItem("strawberries", 0.20)
        iceCream.addItem("oreos", 0.20)
        iceCream.addItem("gummy bears", 0.20)
        iceCream.addItem("marshmallows", 0.15)
        iceCream.addItem("hot fudge 1 oz", 0.15)
        iceCream.addItem("hot fudge 2 oz", 0.25)
        iceCream.addItem("hot fudge 3 oz", 0.30)
        iceCream.addItem("small", 2.99)
        iceCream.addItem("medium", 3.99)
        iceCream.addItem("large", 4.99)

        iceCreamFlavors = arrayListOf("Vanilla", "Chocolate", "Strawberry");
        iceCreamSize = arrayListOf("Small", "Medium", "Large");

        checkboxArray = arrayListOf<CheckBox>(
            checkBox_almonds,
            checkBox_brownies,
            checkBox_gummyBears,
            checkBox_mAndM,
            checkBox_marshmallows,
            checkBox_oreos,
            checkBox_peanuts,
            checkBox_strawberries,
        );

        var flavorsAdapter =
            ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, iceCreamFlavors)
        var sizeAdapter =
            ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, iceCreamSize)

        spinner_iceCreamFlavors.adapter = flavorsAdapter;
        spinner_iceCreamSize.adapter = sizeAdapter;

        spinner_iceCreamSize.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {

            override fun onItemSelected(
                parent: AdapterView<*>?,
                view: View?,
                position: Int,
                id: Long
            ) {

                updateUI();
            }

            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }


        // seekBar
        seekBar_iceCream.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {

            override fun onProgressChanged(p0: SeekBar?, position: Int, p2: Boolean) {

                text_ounces.text = "${position} oz"
                updateUI();
            }

            override fun onStartTrackingTouch(p0: SeekBar?) {}

            override fun onStopTrackingTouch(p0: SeekBar?) {}

        })

    }

    fun handleCheckBox(view: View) {
        updateUI();
    }

    fun updateUI() {

        total = 0.0;
        orderString = "";
        lateinit var viewText:String;

        // flavors
        orderString += "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tFLAVOR\n\n" +
                "${spinner_iceCreamFlavors.selectedItem}\n\n"

        // size
        orderString += "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tSIZE\n\n" +
                "${spinner_iceCreamSize.selectedItem} : ${numberFormat.format(iceCream.getItem(spinner_iceCreamSize.selectedItem as String)?.price ?: 0.00)}\n\n"
        total += iceCream.getItem(spinner_iceCreamSize.selectedItem.toString())?.price ?: 0.00

        orderString += "\n\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tTOPPINGS\n\n"

        // toppings
        if (checkBox_peanuts.isChecked){

            viewText = checkBox_peanuts.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_almonds.isChecked){

            viewText = checkBox_almonds.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_mAndM.isChecked){

            viewText = checkBox_mAndM.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_brownies.isChecked){

            viewText = checkBox_brownies.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_strawberries.isChecked){

            viewText = checkBox_strawberries.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_oreos.isChecked){

            viewText = checkBox_oreos.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_gummyBears.isChecked){

            viewText = checkBox_gummyBears.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

        if (checkBox_marshmallows.isChecked){

            viewText = checkBox_marshmallows.text as String;
            total += iceCream.getItem(viewText)?.price ?: 0.0

            orderString += "${iceCream.getItem(viewText)?.item} : ${numberFormat.format(iceCream.getItem(viewText)?.price)} \n"
        }

                            // hot fudge
        if (seekBar_iceCream.progress > 0 ) {

            var fudgeText:String = text_hotFudge.text as String + " " + text_ounces.text as String;

            total += iceCream.getItem("${text_hotFudge.text} ${text_ounces.text}")!!.price
            orderString += "${iceCream.getItem(fudgeText)?.item} : ${numberFormat.format(iceCream.getItem(fudgeText)?.price)} \n"

        }

        text_cost.text = numberFormat.format(total)
    }

    fun order(view: View) {

        updateUI();
        orderString += "\n\nTOTAL : ${numberFormat.format(total)}\n"

        val orderIntent = Intent(this, menu_orderHistory::class.java)

        println(orderString);
        orderHistory.add(orderString);
        orderIntent.putExtra("orderHistory", orderHistory);
        Toast.makeText(this, "Thank You For Your Order!", Toast.LENGTH_SHORT).show()
        resetAll(view);
    }

    fun max(view: View){

        spinner_iceCreamSize.setSelection(spinner_iceCreamSize.count-1)
        selectToppings();
        seekBar_iceCream.progress = seekBar_iceCream.max
        updateUI();
    }

    fun resetAll(view: View) {


        // reset cost
        total = 0.00;
        text_cost.text = numberFormat.format(total);

        // ITERATE THROUGH ALL CHECK BOXES AND RESETS PRICES
        resetToppings();

        // PUT SPINNERS BACK AT POSITION 0 ("SELECTED")
        spinner_iceCreamFlavors.setSelection(0)
        spinner_iceCreamSize.setSelection(0)

        // PUT SEEKBAR BACK AT POSITION 1
        seekBar_iceCream.setProgress(1)

//        updateUI();


    }

    fun resetToppings() {

        for (x in checkboxArray) {

            if (x.isChecked) x.isChecked = false
        }
    }

    fun selectToppings() {

        for (x in checkboxArray) {

            if ( !x.isChecked ) x.isChecked = true
        }
    }

    // MENU ITEMS
    override fun onCreateOptionsMenu(menu: Menu?): Boolean {

        val inflatter = menuInflater
        inflatter.inflate(R.menu.menu, menu)

        return true;
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {

        val orderIntent = Intent(this, menu_orderHistory::class.java)
        val aboutIntent = Intent(this, menu_about::class.java)

        if (item.itemId == R.id.menu_orderHistory) {

            orderIntent.putExtra("orderHistory", orderHistory);

            startActivity(orderIntent)

        } else if (item.itemId == R.id.menu_about) {

            var string = "My name is Ernesto Louis and this is my Ice Cream Sundae App :)";
            aboutIntent.putExtra("about", string);

            startActivity(aboutIntent)

        }

        return true;
    }
}






