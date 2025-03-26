package VNPayConfig;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.*;
import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

public class Config {

    private static final String vnp_TmnCode = "Q4Z5I9E6";
    private static final String vnp_HashSecret = "KD8KKV4LGH8256G3I41AP147NYOKU11F";
    private static final String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    private static final String returnUrl = "http://localhost:8080/tratra/TransactionServlet";

    public static String createPaymentUrl(long amount, String orderId) {
        try {
            Map<String, String> params = new HashMap<>();
            params.put("vnp_Version", "2.1.0");
            params.put("vnp_Command", "pay");
            params.put("vnp_TmnCode", vnp_TmnCode);
            params.put("vnp_Amount", String.valueOf(amount * 100)); // VNPAY nhận đơn vị VNĐ * 100
            params.put("vnp_CurrCode", "VND");
            params.put("vnp_TxnRef", orderId);
            params.put("vnp_OrderInfo", "Thanh toan don hang " + orderId);
            params.put("vnp_IpAddr", "127.0.0.1");
            params.put("vnp_OrderType", "other");
            params.put("vnp_Locale", "vn");
            params.put("vnp_ReturnUrl", returnUrl);
            params.put("vnp_CreateDate", new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new Date()));

            // Sắp xếp tham số theo thứ tự alphabet
            List<String> keys = new ArrayList<>(params.keySet());
            Collections.sort(keys);

            StringBuilder query = new StringBuilder();
            StringBuilder hashData = new StringBuilder();

            for (String key : keys) {
                String value = URLEncoder.encode(params.get(key), "UTF-8");
                query.append(key).append("=").append(value).append("&");
                hashData.append(key).append("=").append(value).append("&");
            }

            // Xóa ký tự '&' cuối cùng
            query.setLength(query.length() - 1);
            hashData.setLength(hashData.length() - 1);

            // Tạo chữ ký (HMAC-SHA512)
            String secureHash = hmacSHA512(vnp_HashSecret, hashData.toString());
            query.append("&vnp_SecureHash=").append(secureHash);

            return vnp_Url + "?" + query.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static String hmacSHA512(final String key, final String data) {
        try {

            if (key == null || data == null) {
                throw new NullPointerException();
            }
            final Mac hmac512 = Mac.getInstance("HmacSHA512");
            byte[] hmacKeyBytes = key.getBytes();
            final SecretKeySpec secretKey = new SecretKeySpec(hmacKeyBytes, "HmacSHA512");
            hmac512.init(secretKey);
            byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
            byte[] result = hmac512.doFinal(dataBytes);
            StringBuilder sb = new StringBuilder(2 * result.length);
            for (byte b : result) {
                sb.append(String.format("%02x", b & 0xff));
            }
            return sb.toString();

        } catch (Exception ex) {
            return "";
        }
    }

    public static String getRandomNumber(int len) {
        Random rnd = new Random();
        String chars = "0123456789";
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }
}
