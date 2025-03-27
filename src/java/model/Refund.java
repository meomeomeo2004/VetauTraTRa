/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.math.BigDecimal;
import java.text.Bidi;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author ASUS
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
/**
 *
 * @author ASUS
 */
public class Refund {
    private int id;
    private int status;
    private int userId;
    private Integer staffId;
    private int ticketId;
    private String userBankName;
    private String userBankNumber;
    private String userBankAccountName;
    private LocalDateTime createdAt;
    private LocalDateTime handleTime;
    private Long price;
}
