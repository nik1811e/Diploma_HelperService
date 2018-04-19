package course;

import entity.AuthInfEntity;
import entity.CourseEntity;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import util.CommonUtil;
import util.HibernateUtil;
import util.VariablesUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.List;

@WebServlet(urlPatterns = "/courseinformation")
public class CourseInformation extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CourseInformation.class);
    private final int idAuth;
    private Session session;
    private String uuidCourse;
    private String uuidAuth;

    public CourseInformation(String uuidAuth) {
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        this.idAuth = CommonUtil.getIdAuthByUUID(session, uuidAuth);
    }

    public List<CourseEntity> getUserCourse() {
         logger.debug(getClass().getName() + "getUserCourse");
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT c FROM " + VariablesUtil.ENTITY_COURSE + " c WHERE authById =:idAuth", CourseEntity.class)
                    .setParameter("idAuth", session.load(AuthInfEntity.class, idAuth)).getResultList();
        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
        return null;
    }
}
