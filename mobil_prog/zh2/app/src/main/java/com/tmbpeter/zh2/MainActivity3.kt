package com.tmbpeter.zh2

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat

class MainActivity3 : AppCompatActivity() {
    private lateinit var btnBack: Button
    private lateinit var stepsDoneTextView: TextView

    private var finalCompletedSteps: Int = 0
    private var requiredSteps: Int = 0
    private var selectedSpeedTempo: String = "undefined"

    private lateinit var recipientNameEditText: EditText
    private lateinit var recipientTelEditText: EditText
    private lateinit var btnSendSms: Button
    private lateinit var btnSendCall: Button

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main3)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        btnBack = findViewById(R.id.btn_back)

        stepsDoneTextView = findViewById(R.id.steps_done)

        recipientNameEditText = findViewById(R.id.recipiant_name)
        recipientTelEditText = findViewById(R.id.recipiant_tel)
        btnSendSms = findViewById(R.id.send_sms)
        btnSendCall = findViewById(R.id.send_call)

        finalCompletedSteps = intent.getIntExtra("completed_steps", 0)
        requiredSteps = intent.getIntExtra("required_steps", 0)
        selectedSpeedTempo = intent.getStringExtra("selected_speed_tempo") ?: "undefined"

        updateStepsTextView(finalCompletedSteps)

        btnBack.setOnClickListener {
            val intent = Intent(this, MainActivity::class.java)

            intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
            startActivity(intent)

            finish()
        }

        btnSendSms.setOnClickListener {
            val recipientName = recipientNameEditText.text.toString().trim()
            val recipientTel = recipientTelEditText.text.toString().trim()

            if (recipientName.isEmpty() || recipientTel.isEmpty()) {

            } else {
                val smsMessage = "Szia $recipientName! A mai teljesítményem: $finalCompletedSteps / $requiredSteps lépés, $selectedSpeedTempo tempóban. Próbáld ki te is - mozogjunk együtt!"


                val smsIntent = Intent(Intent.ACTION_SENDTO).apply {

                    data = Uri.parse("smsto:$recipientTel")

                    putExtra("sms_body", smsMessage)
                }
                startActivity(smsIntent)
            }
        }

        btnSendCall.setOnClickListener {
            val recipientName = recipientNameEditText.text.toString().trim()
            val recipientTel = recipientTelEditText.text.toString().trim()

            if (recipientName.isEmpty() || recipientTel.isEmpty()) {

            } else {
                val dialIntent = Intent(Intent.ACTION_DIAL).apply {
                    data = Uri.parse("tel:$recipientTel")
                }
                startActivity(dialIntent)
            }
        }
    }

    private fun updateStepsTextView(currentSteps: Int) {
        val stepsText = "$currentSteps / $requiredSteps"
        stepsDoneTextView.text = stepsText
    }
}