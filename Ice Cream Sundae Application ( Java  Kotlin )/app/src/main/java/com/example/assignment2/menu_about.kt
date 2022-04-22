package com.example.assignment2

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.MenuItem
import kotlinx.android.synthetic.main.activity_menu_about.*

class menu_about : AppCompatActivity() {

    var aboutString = "";
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_menu_about)

        supportActionBar!!.title = "About"
        supportActionBar!!.setDisplayHomeAsUpEnabled(true);


        var aboutIntent = intent;

        aboutString = aboutIntent.getStringExtra("about") as String;

        text_about.text = aboutString;
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