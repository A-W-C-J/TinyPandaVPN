package sail

import androidx.multidex.MultiDexApplication
import androidx.preference.PreferenceManager
import com.sail_tunnel.sail.BuildConfig
import com.tencent.mmkv.MMKV
import io.flutter.app.FlutterApplication


class AngApplication : MultiDexApplication() {


    companion object {
        const val PREF_LAST_VERSION = "pref_last_version"
    }

    var firstRun = false
        private set
    override fun onCreate() {
        super.onCreate()
        val defaultSharedPreferences = PreferenceManager.getDefaultSharedPreferences(this)
        firstRun = defaultSharedPreferences.getInt(PREF_LAST_VERSION, 0) != BuildConfig.VERSION_CODE
        if (firstRun)
            defaultSharedPreferences.edit().putInt(PREF_LAST_VERSION, BuildConfig.VERSION_CODE).apply()
        //Logger.init().logLevel(if (BuildConfig.DEBUG) LogLevel.FULL else LogLevel.NONE)
        MMKV.initialize(this)
    }
}