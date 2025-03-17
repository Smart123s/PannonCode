package com.tmbpeter.beadando

import android.content.ContentValues
import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.view.KeyEvent
import android.view.inputmethod.EditorInfo
import android.widget.Button
import android.widget.EditText
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView

class MainActivity : AppCompatActivity(), SensorEventListener {
    private lateinit var recyclerView: RecyclerView
    private lateinit var editText: EditText
    private lateinit var addButton: Button
    private lateinit var adapter: ListAdapter
    private val itemList = mutableListOf<Item>()
    private lateinit var dbHelper: ItemDatabaseHelper

    private lateinit var sensorManager: SensorManager
    private var proximitySensor: Sensor? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        dbHelper = ItemDatabaseHelper(this)

        recyclerView = findViewById<RecyclerView>(R.id.recyclerView)
        editText = findViewById<EditText>(R.id.editTextText)
        addButton = findViewById<Button>(R.id.button)

        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = ListAdapter(itemList, dbHelper)
        recyclerView.adapter = adapter


        loadItemsFromDatabase()

        addButton.setOnClickListener {
            addItemToList()
        }

        // enter lenyomásakor is adja hozzá a listához a szöveget
        editText.setOnEditorActionListener { _, actionId, event ->
            if (actionId == EditorInfo.IME_ACTION_DONE
                || actionId == EditorInfo.IME_ACTION_SEND
                || (event != null && event.action == KeyEvent.ACTION_DOWN && event.keyCode == KeyEvent.KEYCODE_ENTER)) {
                addItemToList()
                return@setOnEditorActionListener true
            }
            return@setOnEditorActionListener false
        }


        // proximity sensor

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        proximitySensor = sensorManager.getDefaultSensor(Sensor.TYPE_PROXIMITY)

        if (proximitySensor == null) {
            Toast.makeText(this, "Proximity sensor not available on this device", Toast.LENGTH_SHORT).show()
        }
    }
    private fun addItemToList() {
        val text = editText.text.toString().trim()
        if (text.isNotEmpty()) {
            val newItem = Item(text)
            val newId = addItemToDatabase(newItem)
            val newItemWithId = newItem.copy(id = newId)
            adapter.addItem(newItemWithId)
            editText.text.clear()
        }
    }

    private fun addItemToDatabase(item: Item): Long {
        val db = dbHelper.writableDatabase
        val values = ContentValues().apply {
            put("text", item.text)
        }
        val newRowId = db.insert(ItemDatabaseHelper.TABLE_ITEMS, null, values)
        db.close()
        return newRowId
    }

    private fun loadItemsFromDatabase() {
        itemList.clear()
        val db = dbHelper.readableDatabase
        val projection = arrayOf("_id", "text")
        val cursor = db.query(
            ItemDatabaseHelper.TABLE_ITEMS,
            projection,
            null,
            null,
            null,
            null,
            null
        )

        cursor?.use {
            while (it.moveToNext()) {
                val id = it.getLong(it.getColumnIndexOrThrow("_id"))
                val text = it.getString(it.getColumnIndexOrThrow("text"))
                itemList.add(Item(text, id))
            }
        }
        cursor?.close()
        db.close()
    }

    override fun onDestroy() {
        dbHelper.close()
        super.onDestroy()
    }


    // proximity sensor
    override fun onResume() {
        super.onResume()
        proximitySensor?.let {
            sensorManager.registerListener(this, it, SensorManager.SENSOR_DELAY_NORMAL)
        }
    }

    override fun onPause() {
        super.onPause()
        sensorManager.unregisterListener(this)
    }

    override fun onSensorChanged(event: SensorEvent) {
        if (event.sensor.type == Sensor.TYPE_PROXIMITY) {
            val distance = event.values[0]
            if (distance < 1) {
                Toast.makeText(this, "Too close", Toast.LENGTH_SHORT).show()
                val intent = Intent(this, SecondActivity::class.java)
                startActivity(intent)
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }

}