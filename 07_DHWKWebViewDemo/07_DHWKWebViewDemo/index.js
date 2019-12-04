/**
 * Created by swartz006 on 2017/6/29.
 */

function callJS() {
//    window.webkit.messageHandlers.callJS.postMessage(null)
    document.getElementById("text").innerText = document.cookie
}

function callOC() {
    window.webkit.messageHandlers.callOC.postMessage(null)
}

function showText() {
    document.getElementById("text").innerText = "成功调用了js函数"
}
