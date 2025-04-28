package com.tmbpeter.zh2

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.Bundle
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import java.io.FileOutputStream
import java.io.IOException
import kotlin.math.sqrt

class MainActivity2 : AppCompatActivity(), SensorEventListener {

    private lateinit var speedDisplayTextView: TextView
    private lateinit var btnFinish: Button
    private lateinit var stepsDoneTextView: TextView

    private var sensorManager: SensorManager? = null
    private var accelerometerSensor: Sensor? = null
    private var lastAccelerationMagnitude: Float = 0f

    private var currentSteps: Int = 0
    private var requiredSteps: Int = 0

    private val STEP_THRESHOLD = 15f
    // így könnyebb tesztelni
    // private val STEP_THRESHOLD = 3f

    // duplikált lefutás prevenció :)
    private var targetReached = false

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main2)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        speedDisplayTextView = findViewById(R.id.speed_display)

        val selectedSpeedTempo = intent.getStringExtra("selected_speed_tempo")

        val template_text = "Megtett lépések száma\n... tempóban: "

        speedDisplayTextView.text = template_text + selectedSpeedTempo

        btnFinish = findViewById(R.id.btn_finish)
        stepsDoneTextView = findViewById(R.id.steps_done)

        val sharedPrefs = getSharedPreferences("StepPrefs", Context.MODE_PRIVATE)
        requiredSteps = sharedPrefs.getInt("reqStep", 0)

        updateStepsTextView(currentSteps)

        sensorManager = getSystemService(Context.SENSOR_SERVICE) as SensorManager
        accelerometerSensor = sensorManager?.getDefaultSensor(Sensor.TYPE_ACCELEROMETER)

        btnFinish.setOnClickListener {
            finishBtnClick()
        }

    }

    override fun onSensorChanged(event: SensorEvent?) {
        if (event?.sensor?.type == Sensor.TYPE_ACCELEROMETER) {
            val x = event.values[0]
            val y = event.values[1]
            val z = event.values[2]

            val accelerationMagnitude = sqrt(x * x + y * y + z * z)
            val delta = Math.abs(accelerationMagnitude - lastAccelerationMagnitude)

            if (delta > STEP_THRESHOLD) {
                currentSteps++
                updateStepsTextView(currentSteps)

                if (currentSteps >= requiredSteps && !targetReached) {
                    targetReached = true
                    Toast.makeText(this, "Congratulations!", Toast.LENGTH_SHORT).show()
                    finishBtnClick()
                }
            }

            lastAccelerationMagnitude = accelerationMagnitude
        }
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {

    }

    private fun updateStepsTextView(currentSteps: Int) {
        val stepsText = "$currentSteps / $requiredSteps"
        stepsDoneTextView.text = stepsText
    }


    override fun onResume() {
        super.onResume()
        accelerometerSensor?.also { accel ->
            sensorManager?.registerListener(this, accel, SensorManager.SENSOR_DELAY_GAME)
        }
        updateStepsTextView(currentSteps)
    }

    override fun onPause() {
        super.onPause()
        sensorManager?.unregisterListener(this)
    }

    override fun onDestroy() {
        super.onDestroy()
        sensorManager?.unregisterListener(this)
    }

    private fun finishBtnClick() {
        val currentSelectedSpeedTempo = intent.getStringExtra("selected_speed_tempo") ?: "undefined"

        val resultString = "$currentSteps / $requiredSteps / $currentSelectedSpeedTempo"

        var fileOutputStream: FileOutputStream? = null
        try {
            fileOutputStream = openFileOutput("results.txt", Context.MODE_PRIVATE)
            fileOutputStream.write(resultString.toByteArray())

            Toast.makeText(this, "Results saved: $resultString", Toast.LENGTH_SHORT).show()

        } catch (e: IOException) {
            e.printStackTrace()
        } finally {
            fileOutputStream?.close()
        }

        val intent = Intent(this, MainActivity3::class.java).apply {
            putExtra("required_steps", requiredSteps)
            putExtra("completed_steps", currentSteps)
            putExtra("selected_speed_tempo", intent.getStringExtra("selected_speed_tempo") ?: "undefined")
        }

        startActivity(intent)
    }
}