package entities;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Entity
@Table(name = "visitations")
public class Visitation {
    @Id
    @Column
    private int id;

    @Column(nullable = false)
    private Date date;

    @Column(nullable = false)
    private String comments;

    @ManyToOne(optional = false)
    @JoinColumn(referencedColumnName = "id")
    private Patient patient;

}
