package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "credit_cards")
public class CreditCard extends BillingDetail{

    @Column(nullable = false)
    private String type;

    @Column(nullable = false, name = "expiration_month")
    private short expirationMonth;

    @Column(nullable = false, name = "expiration_year")
    private short expirationYear;


}
