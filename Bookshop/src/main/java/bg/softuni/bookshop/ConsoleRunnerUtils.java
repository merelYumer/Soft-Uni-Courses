package bg.softuni.bookshop;

import bg.softuni.bookshop.enums.AgeRestriction;
import bg.softuni.bookshop.enums.EditionType;
import bg.softuni.bookshop.services.author.AuthorService;
import bg.softuni.bookshop.services.book.BookService;
import bg.softuni.bookshop.services.seed.SeedService;
import org.yaml.snakeyaml.emitter.ScalarAnalysis;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Scanner;

public class ConsoleRunnerUtils {
    Scanner scanner = new Scanner(System.in);
    private final LocalDate BOOK_YEAR_AFTER = LocalDate.of(2000, 1, 1);
    private final LocalDate BOOK_YEAR_BEFORE = LocalDate.of(1990, 1, 1);

    private SeedService seedService;
    private BookService bookService;
    private  AuthorService authorService;

    private void getAllBooksAfterAGivenYear() {
        this.bookService
                .findAllByReleaseDateAfter(BOOK_YEAR_AFTER)
                .forEach(book -> System.out.println(book.getTitle()));
    }

    private void getAllAuthorsWithBooksReleaseDateBefore() {
        this.authorService
                .findDistinctByBooksBefore(BOOK_YEAR_BEFORE)
                .forEach(author -> System.out.println(author.getFirstName() + " " + author.getLastName()));
    }

    private void getAllOrderByBooks() {
        this.authorService.findAllOrderByBooks()
                .forEach(author -> System.out.println(author.toStringWithCount()));
    }

    private void findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc() {
        this.bookService
                .findAllByAuthorFirstNameAndAuthorLastNameOrderByReleaseDateDescTitleAsc("George", "Powell")
                .forEach(book -> System.out.println(book.getTitle() + " "
                        + book.getReleaseDate() + " "
                        + book.getCopies()));
    }

    private void findAllByAgeRestriction() {
        String restrictionType = scanner.nextLine();
        AgeRestriction restriction = AgeRestriction.valueOf(restrictionType.toUpperCase());

        this.bookService
                .findAllByAgeRestriction(restriction)
                .forEach(book -> System.out.println(book.getTitle()));
    }

    private void findAllByEditionTypeAndCopiesLessThan(){
        this.bookService
                .findAllByEditionTypeAndCopiesLessThan(EditionType.GOLD, 5000)
                .forEach(book -> System.out.println(book.getTitle()));
    }

    private void findAllByPriceLessThanOrPriceGreaterThan(){
        this.bookService
                .findAllByPriceLessThanOrPriceGreaterThan(BigDecimal.valueOf(5L), BigDecimal.valueOf(40L))
                .forEach(book -> System.out.printf("%s - $%.2f%n", book.getTitle(), book.getPrice()));
    }

    private void findAllByReleaseDateNot(){
        int date = Integer.parseInt(scanner.nextLine());

        this.bookService
                .findAllByReleaseDateNot(LocalDate.of(date, 1, 1))
                .forEach(book -> System.out.println(book.getTitle()));
    }

    private void findAllByReleaseDateBefore(){
        String date = scanner.nextLine();

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
        LocalDate parsedDate = LocalDate.parse(date, formatter);

        this.bookService
                .findAllByReleaseDateBefore(parsedDate)
                .forEach(book -> System.out.printf("%s %s %.2f%n", book.getTitle(), book.getEditionType(), book.getPrice()));
    }

    private void findAuthorByFirstNameEndingWith(){
        String nameEnd = scanner.nextLine();

        this.authorService
                .findAuthorByFirstNameEndingWith(nameEnd)
                .forEach(author -> System.out.printf("%s %s%n", author.getFirstName(), author.getLastName()));
    }

    private void findAllByTitleContainsIgnoreCase(){
        String searchedString = scanner.nextLine();

        this.bookService
                .findAllByTitleContainsIgnoreCase(searchedString)
                .forEach(book -> System.out.printf("%s %n", book.getTitle()));
    }

    private void findAllByAuthorLastNameStartingWith(){
        String searchedString = scanner.nextLine();

        this.bookService
                .findAllByAuthorLastNameStartingWith(searchedString)
                .forEach(book -> System.out.printf("%s (%s %s)%n", book.getTitle(), book.getAuthor().getFirstName(), book.getAuthor().getLastName()));
    }

    private void findAllByTitleIsGreaterThan(){
        int size = Integer.parseInt(scanner.nextLine());

        System.out.println(this.bookService.findAllByTitleIsGreaterThan(size));
    }

    private void findAllOrderByBooks() {
        this.authorService
                .findAllOrderByBooks()
                .forEach(author -> System.out.printf("%s %s - %d%n", author.getFirstName(), author.getLastName(), author.getBooks().size()));
    }

}
