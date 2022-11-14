package bg.softuni.bookshop.services.author;

import bg.softuni.bookshop.entities.Author;

import java.time.LocalDate;
import java.util.List;

public interface AuthorService {
    void seedAuthors(List<Author> authors);

    boolean isDataSeeded();

    Author getRandomAuthor();

    List<Author> findDistinctByBooksBefore(LocalDate date);

    List<Author> findAllOrderByBooks();
    List<Author> findAuthorByFirstNameEndingWith(String end);


}
