package com.tmbpeter.zh2

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.RadioButton
import android.widget.RadioGroup
import android.widget.TextView
import android.widget.Toast
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import java.io.File
import java.io.FileInputStream
import java.io.IOException

class MainActivity : AppCompatActivity() {

    private lateinit var reqStepEditText: EditText
    private lateinit var btnStart: Button
    private lateinit var speedRadioGroup: RadioGroup
    private lateinit var lastResultTextView: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        reqStepEditText = findViewById(R.id.reqstep)
        btnStart = findViewById(R.id.btn_start)
        speedRadioGroup = findViewById(R.id.speed_display)
        lastResultTextView = findViewById(R.id.last_result)

        findViewById<RadioButton>(R.id.speed_normal).isChecked = true

        btnStart.setOnClickListener {
            val reqStepText = reqStepEditText.text.toString()
            val reqStepValue = reqStepText.toIntOrNull()

            if (reqStepValue == null || reqStepValue < 1 || reqStepValue > 1000) {
                Toast.makeText(this, "Nem 1 es ezer kozotti ertek!", Toast.LENGTH_LONG)
                    .show()
            } else {
                val sharedPrefs = getSharedPreferences("StepPrefs", Context.MODE_PRIVATE)
                with(sharedPrefs.edit()) {
                    putInt(
                        "reqStep",
                        reqStepValue
                    )
                    apply()
                }

                Toast.makeText(this, "Lepesszamlalo elinditva :)", Toast.LENGTH_SHORT).show()

                val selectedSpeedId = speedRadioGroup.checkedRadioButtonId
                val selectedSpeedText: String? = if (selectedSpeedId != -1) {
                    findViewById<RadioButton>(selectedSpeedId)?.text?.toString()
                } else {
                    null
                }

                val intent = Intent(this, MainActivity2::class.java).apply {
                    putExtra("selected_speed_tempo", selectedSpeedText)
                }
                startActivity(intent)
            }
        }
        loadLastResult()
    }

    override fun onResume() {
        super.onResume()
        loadLastResult()
    }

    private fun loadLastResult() {
        var fileInputStream: FileInputStream? = null
        var loadedReqStep = 100

        try {
            val file = File(filesDir, "results.txt")
            if (file.exists()) {
                fileInputStream = openFileInput("results.txt")
                val fileContent = fileInputStream.readBytes().toString(Charsets.UTF_8)
                lastResultTextView.text = "Utolsó eredmény: $fileContent"

                val parts = fileContent.split("/")
                if (parts.size == 3) {
                    val targetStepsString = parts[1].trim()
                    val parsedTargetSteps = targetStepsString.toIntOrNull()

                    if (parsedTargetSteps != null) {
                        loadedReqStep = parsedTargetSteps
                    }
                }

            }
        } catch (e: Exception) {
        } finally {
            try {
                fileInputStream?.close()
            } catch (e: IOException) {
            }
        }
        reqStepEditText.setText(loadedReqStep.toString())
    }
}