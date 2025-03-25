/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

/**
 *
 * @author ASUS
 */
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class Customer {

    private int id;
    private int user_id;   
    private String phoneNumber;
    private String fullName;
    private String address;
    private int status;
public Customer(String fullName, String phoneNumber, String address, int status) {
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.status = status;
    }
}
