package com.ludisy.app.plugin

import com.ludisy.app.plugin.data.AppDatabase
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.Single

interface WorkoutMethodCalls<T> {
    fun checkMethodCalls(appDatabase: AppDatabase, call: MethodCall, result: MethodChannel.Result)

    fun getAllData(appDatabase: AppDatabase): Single<List<T>>

    fun removeAllData(appDatabase: AppDatabase): Single<Unit>
}