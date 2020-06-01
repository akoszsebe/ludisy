package com.ludisy.app.plugin.data.dao;

import com.ludisy.app.plugin.data.model.RollerSkatingObj;

import androidx.room.Dao;
import androidx.room.Insert;
import androidx.room.OnConflictStrategy;
import androidx.room.Query;

@Dao
interface RollerSkatingDao {
    @Query("SELECT * FROM RollerSkatingObj")
    fun getAll(): List<RollerSkatingObj>

    @Insert
    fun insertAll(vararg rollerSkatingObj: RollerSkatingObj)

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    fun insert(rollerSkatingObj: RollerSkatingObj?): Long

    @Query("DELETE FROM RollerSkatingObj")
    fun deleteAll()
}
