/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.sql.Timestamp;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import model.Cabin;
import model.Luggage;
import model.Route;
import model.Seat;
import model.Staff;
import model.Ticket;
import model.Train;
import model.Transaction;

/**
 *
 * @author dtam6
 */
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TicketDTO {

    private int id;
    private int status;
    private Luggage weight;
    private Timestamp bookingDate;
    private Route route;
    private Train train;
    private Cabin cabin;
    private Seat seat;
    private Staff staff;
    private int transactionId;
    private boolean canCanceled;

    public TicketDTO(Ticket ticket, Luggage luggage, Route route, Train train, Cabin cabin, Seat seat, Staff staff, boolean canCanceled) {
        this.id = ticket.getId();
        this.status = ticket.getStatus();
        this.weight = luggage;
        this.bookingDate = ticket.getBookingDate();
        this.route = route;
        this.seat = seat;
        this.staff = staff;
        this.transactionId = ticket.getTransactionId();
        this.canCanceled = canCanceled;
        this.train = train;
        this.cabin = cabin;
    }
}
