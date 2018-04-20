package course;

import com.google.gson.Gson;
import course.to.ResourceTO;
import course.to.SectionTO;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import util.HibernateUtil;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.util.List;

@WebServlet(urlPatterns = "/resourceinformation")
public class ResourceInformation extends HttpServlet {
    private static final Logger logger = Logger.getLogger(CourseInformation.class);
    private Gson gson = new Gson();

    public List<ResourceTO> getSectionResource(String uuidSection, String uuidCourse) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            List<SectionTO> sectionsTOList = new SectionInformation().getCourseSection(uuidCourse);
            List<ResourceTO> resourceTOList;
            for (SectionTO sn : sectionsTOList) {
                if (sn.getUuidSection().equals(uuidSection)) {
                    resourceTOList = sn.getResource();
                    return resourceTOList;
                }
            }
            return null;
        } catch (Exception ex) {
            return null;
        } finally {
            if (session.isOpen()) {
                session.close();
            }
        }
    }

}
