package com.tmbpeter.zh1

import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.widget.Button
import android.widget.EditText
import android.widget.ImageButton
import android.widget.ImageView
import android.widget.SeekBar
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        // lejátszás gomb
        val button2: Button = findViewById(R.id.button2)

        button2.setOnClickListener {
            val imageView: ImageView = findViewById(R.id.imageView)


            if (button2.text == getString(R.string.play)) {
                button2.text = getString(R.string.pause)
                imageView.setImageDrawable(ContextCompat.getDrawable(this, R.drawable.cd_colorful))
            } else {
                button2.text = getString(R.string.play)
                imageView.setImageDrawable(ContextCompat.getDrawable(this, R.drawable.cd_grayscale))
            }

        }

        // galéra megnyitós gomb
        val imageButton: ImageButton = findViewById(R.id.imageButton)
        imageButton.setOnClickListener {
            val intent = Intent(Intent.ACTION_VIEW, MediaStore.Images.Media.EXTERNAL_CONTENT_URI)
            startActivity(intent)
        }

        // dalok listája gomb
        val button1: Button = findViewById(R.id.button)
        button1.setOnClickListener {
            val intent = Intent(this, MusicListActivity::class.java)
            val editTextText: EditText = findViewById(R.id.editTextText)
            if (editTextText.text.isEmpty()) {
                startActivity(intent)
            } else {
                val builder = AlertDialog.Builder(this)

                builder.setTitle(getString(R.string.save_title))
                builder.setMessage(getString(R.string.save_text))

                builder.setPositiveButton(getString(R.string.yes)) { dialog, which ->
                    dialog.dismiss()
                }

                builder.setNegativeButton(getString(R.string.no)) { dialog, which ->
                    val intent = Intent(this, MusicListActivity::class.java)
                    startActivity(intent)
                    dialog.dismiss()
                    Toast.makeText(this, getString(R.string.save_success), Toast.LENGTH_LONG).show()
                }

                builder.setCancelable(false)

                val dialog = builder.create()
                dialog.show()
            }
        }

        // seekbar szöveg
        val seekBar: SeekBar = findViewById(R.id.seekBar)
        val textView2: TextView = findViewById(R.id.textView2)

        seekBar.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
            override fun onProgressChanged(seekBar: SeekBar?, progress: Int, fromUser: Boolean) {
                textView2.text = getString(R.string.volume) + ": " + progress.toString()
            }

            override fun onStartTrackingTouch(seekBar: SeekBar?) {
            }

            override fun onStopTrackingTouch(seekBar: SeekBar?) {
            }
        })
        textView2.text = getString(R.string.volume) + ": " + seekBar.progress.toString()


        // zenecím beállítása 2. activityből
        val textViewTitle = findViewById<TextView>(R.id.textView)
        val clickedText = intent.getStringExtra("clicked_text")

        clickedText?.let {
            textViewTitle.text = it
        }
    }
}