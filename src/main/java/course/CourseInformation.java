package course;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(urlPatterns = "/courseinformation")
public class CourseInformation extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CourseInformation.class);
    private final String uuidCourse;
    private Session session;


    public CourseInformation(String uuidCourse) {
        this.uuidCourse = uuidCourse;
    }


}
