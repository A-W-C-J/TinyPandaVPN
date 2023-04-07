package v2ray.ui

import android.os.Bundle

import androidx.fragment.app.Fragment
import com.google.android.material.tabs.TabLayoutMediator
import com.sail_tunnel.sail.R
import com.sail_tunnel.sail.databinding.ActivityRoutingSettingsBinding
import sail.AppConfig

import v2ray.ui.BaseActivity

class RoutingSettingsActivity : BaseActivity() {
    private lateinit var binding: ActivityRoutingSettingsBinding

    private val titles: Array<out String> by lazy {
        resources.getStringArray(R.array.routing_tag)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityRoutingSettingsBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        title = getString(R.string.title_pref_routing_custom)
//        supportActionBar?.setDisplayHomeAsUpEnabled(true)

        val fragments = ArrayList<Fragment>()
        fragments.add(RoutingSettingsFragment().newInstance(AppConfig.PREF_V2RAY_ROUTING_AGENT))
        fragments.add(RoutingSettingsFragment().newInstance(AppConfig.PREF_V2RAY_ROUTING_DIRECT))
        fragments.add(RoutingSettingsFragment().newInstance(AppConfig.PREF_V2RAY_ROUTING_BLOCKED))

//        val adapter = FragmentAdapter(this, fragments)
//        binding.viewpager.adapter = adapter
//        //tablayout.setTabTextColors(Color.BLACK, Color.RED)
//        TabLayoutMediator(binding.tablayout, binding.viewpager) { tab, position ->
//            tab.text = titles[position]
//        }.attach()
    }
}
