package com.tmbpeter.beadando

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageButton
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class ListAdapter(private val itemList: MutableList<Item>, private val dbHelper: ItemDatabaseHelper) :
    RecyclerView.Adapter<ListAdapter.ViewHolder>() {

    class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        val textView: TextView = itemView.findViewById(R.id.itemTextView)
        val deleteButton: ImageButton = itemView.findViewById(R.id.deleteButton)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val itemView = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_layout, parent, false)
        return ViewHolder(itemView)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        val currentItem = itemList[position]
        holder.textView.text = currentItem.text

        holder.deleteButton.setOnClickListener {
            currentItem.id?.let { itemIdToDelete ->
                removeItem(position, itemIdToDelete)
            }
        }
    }

    override fun getItemCount() = itemList.size

    fun addItem(item: Item) {
        itemList.add(item)
        notifyItemInserted(itemList.size - 1)
    }

    private fun removeItem(position: Int, itemId: Long) {
        val db = dbHelper.writableDatabase
        val whereClause = "_id = ?"
        val whereArgs = arrayOf(itemId.toString())
        val rowsDeleted = db.delete(ItemDatabaseHelper.TABLE_ITEMS, whereClause, whereArgs)
        db.close()

        if (rowsDeleted > 0) {
            itemList.removeAt(position)
            notifyItemRemoved(position)
        }
    }
}