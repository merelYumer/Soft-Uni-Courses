package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Set;

@Getter
@Setter
@Entity
@Table(name = "billing_details")
public class BillingDetail {
    @Id
    @Column
    private int id;

    @Column(unique = true, nullable = false)
    private Long number;

    @ManyToOne
    private User user;

}
