package course;

import com.google.gson.Gson;
import course.to.CourseStructureTO;
import course.to.SectionTO;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import util.CommonUtil;
import util.HibernateUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = "/sectioninformation")
public class SectionInformation extends HttpServlet {
    private static final Logger logger = Logger.getLogger(SectionInformation.class);

    public List<SectionTO> getCourseSection(String uuidCourse) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            CourseStructureTO courseStructureTO = new Gson().fromJson(CommonUtil.getJsonStructure(session, uuidCourse), CourseStructureTO.class);
            return new ArrayList<>(courseStructureTO.getSection());
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
    }
}
