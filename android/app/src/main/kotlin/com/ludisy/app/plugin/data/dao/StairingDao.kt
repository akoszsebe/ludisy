package com.ludisy.app.plugin.data.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.ludisy.app.plugin.data.model.StairingObj

@Dao
interface StairingDao {
    @Query("SELECT * FROM StairingObj")
    fun getAll(): List<StairingObj>

    @Insert
    fun insertAll(vararg stairingObj: StairingObj)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(stairingObj: StairingObj?): Long

    @Query("DELETE FROM StairingObj")
    fun deleteAll()
}