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
    private Session session;

    public List<SectionTO> getCourseSection(String uuidCourse) {
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            CourseStructureTO courseStructureTO = new Gson().fromJson(CommonUtil.getJsonStructure(session, uuidCourse), CourseStructureTO.class);
            List<SectionTO> sectionTOList = new ArrayList<>(courseStructureTO.getSection());
            return sectionTOList;
        } catch (Exception ex) {
            return null;
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }
}
