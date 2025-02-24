/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
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

public class Transaction {
    private int id;
    private int customerid;
    private String paymentMethod;
    private int paymentStatus;
    private Date paymentDate;
    private int quantity;
    private BigDecimal amountPaid;
    private String vouchercode;
}
