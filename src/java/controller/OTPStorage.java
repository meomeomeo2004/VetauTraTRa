/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author ASUS
 */import java.time.LocalDateTime;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class OTPStorage {
    // OTP hết hạn sau 10 phút
    private static final int OTP_VALID_DURATION = 10;

    // HashMap lưu email và OTP tương ứng với thời gian hết hạn
    private static final Map<String, OTPDetails> otpMap = new ConcurrentHashMap<>();

    // Class lưu chi tiết OTP
    public static class OTPDetails {
        String otp;
        LocalDateTime expiryTime;

        public OTPDetails(String otp, LocalDateTime expiryTime) {
            this.otp = otp;
            this.expiryTime = expiryTime;
        }
    }

    // Lưu OTP
    public static void saveOTP(String email, String otp) {
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(OTP_VALID_DURATION);
        otpMap.put(email, new OTPDetails(otp, expiryTime));
    }

    // Kiểm tra OTP
    public static boolean validateOTP(String email, String otp) {
        OTPDetails details = otpMap.get(email);
        if (details == null || LocalDateTime.now().isAfter(details.expiryTime)) {
            otpMap.remove(email);
            return false;
        }
        boolean isValid = details.otp.equals(otp);
        if (isValid) {
            otpMap.remove(email); // Xóa OTP sau khi dùng thành công
        }
        return isValid;
    }
}
