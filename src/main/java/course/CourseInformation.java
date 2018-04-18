package course;

import entity.CourseEntity;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import util.HibernateUtil;
import util.MailUtil;
import util.VariablesUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.Arrays;
import java.util.List;

@WebServlet(urlPatterns = "/courseinformation")
public class CourseInformation extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(CourseInformation.class);
    private Session session;
    private String uuidCourse;
    private String uuidAuth;

    public CourseInformation(String uuidCourse) {
        try {
            this.uuidCourse = uuidCourse;
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + Arrays.toString(ex.getStackTrace()));
        }
    }

    public List<CourseEntity> getCourseInformationByUuid() {
        LOGGER.debug(getClass().getName() + " getCourseInformationByUuid");
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT l FROM " + VariablesUtil.ENTITY_COURSE + " l WHERE uuid = :uuid", CourseEntity.class)
                    .setParameter("uuid", uuidCourse).getResultList();
        } catch (Exception ex) {
            LOGGER.error(ex.getLocalizedMessage());
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
        return null;
    }
}
