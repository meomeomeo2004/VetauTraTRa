/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
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


public class Ticket {
    private int id;
    private int status;
    private int luggageType;
    private Timestamp bookingDate; // DATETIME stored as String in format "yyyy-MM-dd HH:mm:ss"
    private int routeId;
    private int seatId;
    private int staffId; // Nullable
    private int transactionId;
    
}
