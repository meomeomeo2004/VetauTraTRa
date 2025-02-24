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

/**
 *
 * @author ASUS
 */

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor

public class Seat {
    private int id;
    private String name;
    private long price;
    private int cabinid;
    private int status;
   
}
