package kingtous.cn.code_running_front.app


import android.content.Context
import androidx.multidex.MultiDex
import com.sk.flutterpatch.FlutterPatch
import com.tencent.bugly.Bugly
import com.tencent.bugly.beta.Beta
import com.tencent.bugly.crashreport.CrashReport
import io.flutter.Log
import io.flutter.app.FlutterApplication


class MyApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        Log.i("Kingtous", "init bugly.")
        Bugly.init(applicationContext, "3777ebdb44", false)
//        FlutterMain.startInitialization(this)
//        FlutterPatch.hookIsUseTinker()
//        FlutterPatch.reflect(FlutterPatch.getLibPath(this))
    }

    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        // you must install multiDex whatever tinker is installed!
        MultiDex.install(base)
        // 安装tinker
        Beta.installTinker()
    }

}