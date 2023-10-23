import { initializeApp } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-analytics.js";
import { getMessaging, getToken, onMessage } from "https://www.gstatic.com/firebasejs/10.4.0/firebase-messaging.js";

const firebaseConfig = {
    apiKey: "",
    authDomain: "",
    projectId: "",
    storageBucket: "",
    messagingSenderId: "",
    appId: "",
    measurementId: ""
};

const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

const messaging = getMessaging(app);

async function sendTokenToServer(token) {
    try {
        const response = await fetch('/storeToken', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ token })
        });
        const data = await response.json();
        console.log("Token sent to server:", data);
    } catch (error) {
        console.error('Error sending token:', error);
    }
}

messaging.onTokenChange = async () => {
    try {
        const token = await getToken(messaging);
        console.log('Refreshed token:', token);
        await sendTokenToServer(token);
    } catch (err) {
        console.error("Failed to retrieve refreshed token", err);
    }
};

onMessage(messaging, (payload) => {
    console.log('Received foreground message:', payload);
    new Notification(payload.notification.title, {
        body: payload.notification.body,
        icon: payload.data.icon  // data 필드에서 icon 정보를 가져옴
    });
});

function showNotificationModal() {
    var myModal = new bootstrap.Modal(document.getElementById('notificationModal'), {});
    myModal.show();
}

function closeNotificationModal() {
    $('#notificationModal').modal('hide');
}

async function requestNotificationPermission() {
    try {
        const permission = await Notification.requestPermission();
        if (permission === 'granted') {
            console.log('Notification permission granted.');
            const token = await getToken(messaging);
            console.log('token: ' + token);
            await sendTokenToServer(token);
        } else {
            console.log('Unable to get permission to notify.');
        }
        closeNotificationModal();
    } catch (err) {
        console.error("Error requesting notification permission", err);
        closeNotificationModal();
    }
}

document.addEventListener('DOMContentLoaded', (event) => {
    const allowButton = document.getElementById('allowButton');
    const closeButton = document.querySelector('.close');

    if (allowButton) {
        allowButton.addEventListener('click', requestNotificationPermission);
    }
    if (closeButton) {
        closeButton.addEventListener('click', closeNotificationModal);
    }
});

// 페이지 로딩 시 권한 상태 체크
if (Notification.permission === 'default' && isLogged) {
    showNotificationModal();
}

