package com.tmbpeter.zh1

import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.ListView
import android.widget.Switch
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MusicListActivity : AppCompatActivity() {
    private lateinit var listView1: ListView
    private val musicTitles = arrayOf(
        "SuperArtist - Song 1",
        "Extra Super Artist - SonG",
        "Bad Artist - something",
        "Alphabet - aaaAAaaa"
    )

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_music_list)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }


        listView1 = findViewById<ListView>(R.id.listView1)

        val adapter = ArrayAdapter(this, android.R.layout.simple_list_item_1, musicTitles)

        listView1.adapter = adapter

        listView1.setOnItemClickListener { parent, view, position, id ->
            val clickedItemText = musicTitles[position]

            val intent = Intent(this, MainActivity::class.java)

            intent.putExtra("clicked_text", clickedItemText)

            startActivity(intent)
        }

        // switch színváltó
        val randomSwitch: Switch = findViewById(R.id.switch1)
        randomSwitch.setBackgroundColor(Color.parseColor("#CCCC33"))

        randomSwitch.setOnCheckedChangeListener { _, isChecked ->
            if (isChecked) {
                randomSwitch.setBackgroundColor(Color.parseColor("#CCCC33"))
                randomSwitch.text = getString(R.string.turned_on)
            } else {
                randomSwitch.setBackgroundColor(Color.parseColor("#F67068"))
                randomSwitch.text = getString(R.string.turned_off)
            }
        }
    }

}