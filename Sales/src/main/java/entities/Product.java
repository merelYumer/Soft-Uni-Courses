package entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Set;

@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "products")
public class Product {
    @Id
    @Column
    private int id;

    @Column(unique = true, nullable = false)
    private String name;

    @Column
    private double quantity;

    @Column
    private BigDecimal rice;

    @OneToMany(mappedBy = "product")
    private Set<Sale> sales;

}
