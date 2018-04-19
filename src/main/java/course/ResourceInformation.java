package course;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import util.CommonUtil;
import util.HibernateUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;

@WebServlet(urlPatterns = "/resourceinformation")
public class ResourceInformation extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CourseInformation.class);
    private final int idAuth;
    private Session session;

    public ResourceInformation(String uuidAuth) {
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        this.idAuth = CommonUtil.getIdAuthByUUID(session, uuidAuth);
    }
}
