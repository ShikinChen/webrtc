package com.sdk.versionplugin

import org.gradle.api.Plugin
import org.gradle.api.Project
import org.gradle.internal.extensibility.DefaultExtraPropertiesExtension
import java.io.File
import java.net.InetAddress
import java.net.NetworkInterface
import java.util.Enumeration

/**
 *
 * @author shiki
 * @date 2020/8/8
 *
 */
class VersionPlugin : Plugin<Project> {
    override fun apply(project: Project) {
        val ext = project.extensions.findByName("ext") as DefaultExtraPropertiesExtension
        val addr = getLocalHostExactAddress()
        println("----------- Host Address:${addr?.hostAddress} -----------")
        if (addr?.hostAddress != null) {
            ext["host_address"] = addr.hostAddress
        }
    }

    private fun getLocalHostExactAddress(): InetAddress? {
        try {
            var candidateAddress: InetAddress? = null
            val networkInterfaces: Enumeration<NetworkInterface> =
                NetworkInterface.getNetworkInterfaces()
            while (networkInterfaces.hasMoreElements()) {
                val iface: NetworkInterface = networkInterfaces.nextElement()
                // 该网卡接口下的ip会有多个，也需要一个个的遍历，找到自己所需要的
                val inetAddrs: Enumeration<InetAddress> = iface.getInetAddresses()
                while (inetAddrs.hasMoreElements()) {
                    val inetAddr: InetAddress = inetAddrs.nextElement()
                    // 排除loopback回环类型地址（不管是IPv4还是IPv6 只要是回环地址都会返回true）
                    if (!inetAddr.isLoopbackAddress) {
                        if (inetAddr.isSiteLocalAddress) {
                            // 如果是site-local地址，就是它了 就是我们要找的
                            // ~~~~~~~~~~~~~绝大部分情况下都会在此处返回你的ip地址值~~~~~~~~~~~~~
                            return inetAddr
                        }

                        // 若不是site-local地址 那就记录下该地址当作候选
                        if (candidateAddress == null) {
                            candidateAddress = inetAddr
                        }
                    }
                }
            }

            // 如果出去loopback回环地之外无其它地址了，那就回退到原始方案吧
            return candidateAddress ?: InetAddress.getLocalHost()
        } catch (e: Exception) {
            e.printStackTrace()
        }
        return null
    }
}
