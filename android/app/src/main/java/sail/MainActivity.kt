package sail


import android.Manifest
import android.app.Activity
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.VpnService
import android.os.Build
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.lifecycle.lifecycleScope
import com.afollestad.materialdialogs.MaterialDialog
import com.google.common.collect.ImmutableList
import com.google.gson.Gson
import com.sail_tunnel.sail.R
import com.tbruyelle.rxpermissions.RxPermissions
import com.tencent.mmkv.MMKV
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import sail.model.SSconfig
import sail.model.V2raySSConfig
import sail.services.VpnState
import v2ray.dto.*
import v2ray.extension.toast
import v2ray.extension.v2RayApplication
import v2ray.service.V2RayServiceManager
import v2ray.util.MmkvManager
import v2ray.util.MyContextWrapper
import v2ray.util.Utils
import v2ray.viewmodel.MainViewModel
import java.io.File
import java.util.*


class MainActivity : FlutterActivity() {
    private val subStorage by lazy { MMKV.mmkvWithID(MmkvManager.ID_SUB, MMKV.MULTI_PROCESS_MODE) }
    var isRunning = false;
    private val TAG = "MainActivity"
    companion object {
        private const val TUN2SOCKS = "libtun2socks"
//        private const val TUN2SOCKS = "libmmkv.so"
//        lib\arm64-v8a\libmmkv.so
    }
    private val mainStorage by lazy {
        MMKV.mmkvWithID(
            MmkvManager.ID_MAIN,
            MMKV.MULTI_PROCESS_MODE
        )
    }
    var subscribeUrl: String = ""
        private set
    val serversCache = mutableListOf<ServersCache>()
    lateinit var v2raySSConfig: V2raySSConfig
    lateinit var ssConfig: SSconfig
    private val channel = "com.sail_tunnel.sail/vpn_manager"
    lateinit var mainViewModel: MainViewModel
    lateinit var selectConfig: ServerConfig
    var isBillingConnect: Boolean = false;
    var freeNode: String =
        "fres subs"
    var vipNode: String =
        "vip subs"
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mainViewModel = MainViewModel(v2RayApplication)
        saveServer("免费线路", freeNode, true)
        saveServer(
            "VIP线路",
            vipNode,
            true
        )

        this.registerReceiver(mMsgReceiver, IntentFilter(AppConfig.BROADCAST_ACTION_ACTIVITY))
        Core.init(this, MainActivity::class)
        mainViewModel.isRunning.observe(this) { isRunning ->
            this.isRunning = isRunning
        }
        mainViewModel.startListenBroadcast()
    }



    fun startSubscription() {


    }

    override fun onResume() {
        super.onResume()

    }



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getStatus") {
                result.success(this.isRunning)
            } else if (call.method == "toggle") {
                if (mainViewModel.isRunning.value == true) {
                    Utils.stopVService(this)
                    result.success(false)
                } else {
                    val rxPermissions = RxPermissions(this);
                    rxPermissions
                        .requestEach(
                            Manifest.permission.POST_NOTIFICATIONS
                        )
                        .subscribe { permission ->  // will emit 2 Permission objects
                            if (permission.granted) {
                            } else if (permission.shouldShowRequestPermissionRationale) {
                            } else {
                            }
                        }
                    val intent = VpnService.prepare(this)
                    if (intent == null) {
                        onActivityResult(1, Activity.RESULT_OK, null)
                    } else {
                        startActivityForResult(intent, 0)
                    }

                    result.success(true)
                }
            } else if (call.method == "toggleV2ray") {
                startActivity(Intent(this, v2ray.ui.MainActivity::class.java))
            } else if (call.method == "closeV2ray") {
                if (mainViewModel.isRunning.value == true) {
                    Utils.stopVService(this)
                    result.success(true)
                } else
                    result.success(false)
            } else if (call.method == "sendSubscribeUrl") {
                subscribeUrl = call.arguments as String

                result.success(true)
            } else if (call.method == "clearSubs") {
                deleteServer()
                result.success(true)
            } else if (call.method == "toggleSetting") {
                startActivity(Intent(this, v2ray.ui.SettingsActivity::class.java))
                result.success(true)
            } else if (call.method == "toggleLog") {
                startActivity(Intent(this, v2ray.ui.LogcatActivity::class.java))
                result.success(true)
            }else if (call.method == "subSettingButton") {
                startActivity(Intent(this, v2ray.ui.SubSettingActivity::class.java))
                result.success(true)
            } else if (call.method == "getTunnelLog") {
                val config = File(filesDir, VpnState.LEAF_LOG_FILE).readText()
                result.success(config)
            } else if (call.method == "getTunnelConfiguration") {
                val config = File(filesDir, VpnState.CONFIG_FILE).readText()
                result.success(config)
            } else if (call.method == "getRemark") {
                val selectConfig = mainStorage?.decodeString(MmkvManager.KEY_SELECTED_SERVER)
                val config = selectConfig
                    ?.let { MmkvManager.decodeServerConfig(it) }
                result.success(config?.remarks)
            } else if (call.method == "setConfigTemplate") {
                val gson = Gson()
                v2raySSConfig =
                    gson.fromJson(call.arguments as String, V2raySSConfig::class.java);
            } else if (call.method == "setTunnelConfiguration") {
                val gson = Gson()
                ssConfig = gson.fromJson(call.arguments as String, SSconfig::class.java);
                v2raySSConfig.dns.hosts.domain = "googleapis.com"
                v2raySSConfig.outbounds[0].protocol = ssConfig.protocol;
                v2raySSConfig.outbounds[0].settings.servers[0].address = ssConfig.address;
                v2raySSConfig.outbounds[0].settings.servers[0].method = ssConfig.encryptMethod;
                v2raySSConfig.outbounds[0].settings.servers[0].password = ssConfig.password;
                v2raySSConfig.outbounds[0].settings.servers[0].port = ssConfig.port;
//                importCustomizeConfig(gson.toJson(v2raySSConfig))
            } else if (call.method == "update") {
                //
            } else if (call.method == "iap") {
                val productId = call.argument("productId") as String?
                if (productId != null) {
                    startSubscription()
                }
            } else if (call.method == "sendSelectBroadcast") {
//                MessageUtil.sendMsg2UI(this, AppConfig.MSG_MEASURE_SELECT_CONFIG, "")
            } else if (call.method == "sendUpdateSubBroadcast") {
//                Log.e("mMsgReceiver", "configureFlutterEngine: ")
//                MessageUtil.sendMsg2UI(this, AppConfig.MSG_MEASURE_UPDATE_SUBS, "")
            } else {
                result.notImplemented()
            }
        }
    }

    fun startV2Ray() {
        if (mainStorage?.decodeString(MmkvManager.KEY_SELECTED_SERVER).isNullOrEmpty()) {
            return
        }
        V2RayServiceManager.startV2Ray(this)


//        hideCircle()
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
    }

    override fun onActivityResult(request: Int, result: Int, data: Intent?) {
        if (result == RESULT_OK) {
            startV2Ray()

        } else {
            super.onActivityResult(request, result, data)
        }
    }


    override fun onDestroy() {
        super.onDestroy()
        this.unregisterReceiver(mMsgReceiver)
    }

    @RequiresApi(Build.VERSION_CODES.N)
    override fun attachBaseContext(newBase: Context?) {
        val context = newBase?.let {
            MyContextWrapper.wrap(newBase, Utils.getLocale(newBase))
        }
        super.attachBaseContext(newBase)
    }

    private val mMsgReceiver = object : BroadcastReceiver() {
        override fun onReceive(ctx: Context?, intent: Intent?) {
            when (intent?.getIntExtra("key", 0)) {
                AppConfig.MSG_SERVER_SELECTED -> {
                    val config = intent.getStringExtra("content")
                        ?.let { MmkvManager.decodeServerConfig(it) }
                    if (config != null) {
                        flutterEngine?.dartExecutor
                            ?.let {
                                MethodChannel(
                                    it.binaryMessenger,
                                    "com.captain.bestvpn/chaneel"
                                )
                            }?.invokeMethod("setSelectRemark", config.remarks)
                        Log.e("onReceive", "onReceive: " + config.remarks)
                        selectConfig = config
                    }
                }

                AppConfig.MSG_STATE_START_SUCCESS -> {
                    flutterEngine?.dartExecutor
                        ?.let {
                            MethodChannel(
                                it.binaryMessenger,
                                "com.captain.bestvpn/status"
                            )
                        }?.invokeMethod("startVpnSuccess", true)
                }
                AppConfig.MSG_STATE_STOP_SUCCESS -> {
                    flutterEngine?.dartExecutor
                        ?.let {
                            MethodChannel(
                                it.binaryMessenger,
                                "com.captain.bestvpn/status"
                            )
                        }?.invokeMethod("stopVpnSuccess", true)
                }

            }
        }
    }

    private fun saveServer(remark: String, url: String, autoUpdate: Boolean) {
        val subId = Utils.getUuid()
        val subItem: SubscriptionItem = SubscriptionItem()
        subItem.remarks = remark
        subItem.url = url
        subItem.enabled = autoUpdate
        if (TextUtils.isEmpty(subItem.remarks)) {
            toast(R.string.sub_setting_remarks)
        }
        if (subStorage.containsKey(subItem.remarks)) {
            subStorage.removeValueForKey(subItem.remarks)
        }
        subStorage?.encode(subItem.remarks, Gson().toJson(subItem))
    }

    private fun deleteServer(): Boolean {
        MmkvManager.removeAllSubscription()
        return true
    }
}
