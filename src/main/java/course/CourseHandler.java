package course;

import com.google.gson.Gson;
import entity.AuthInfEntity;
import entity.CourseEntity;
import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.*;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet(urlPatterns = "/coursehandler")
public class CourseHandler extends HttpServlet implements Serializable {
    private static final Logger logger = Logger.getLogger(CourseHandler.class);

    private Session session = null;
    private Transaction transaction = null;
    private String uuidAuth;
    private String uuidNewCourse;
    private int idAuth;
    private String errorMessage;
    private Gson gson = new Gson();

    public CourseHandler() {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            transaction = session.beginTransaction();
            this.uuidAuth = new CookieUtil(req).getUserUuidFromToken();
            this.idAuth = CommonUtil.getIdAuthByUUID(session, this.uuidAuth);
            boolean success = addCourse(session, String.valueOf(req.getParameter("name_course").trim()),
                    String.valueOf(req.getParameter("status").trim()), Integer.parseInt(req.getParameter("id_category")), String.valueOf(req.getParameter("desc").trim()));
            if (success) {
                resp.sendRedirect("/pages/course?uuid=" + uuidNewCourse);
            } else {
                PrintWriter printWriter = resp.getWriter();
                printWriter.println(errorMessage);
            }
        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + Arrays.toString(ex.getStackTrace()));
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    private boolean isUniqueNameCourse(String name) {
       /* try {
            CourseStructureTO courseStructureTOgson = null;
            List<Object[]> structureList;
            structureList = (List<Object[]>) session.createQuery("SELECT s.structure FROM " + VariablesUtil.ENTITY_COURSE + " s WHERE s.authById = :id_auth")
                    .setParameter("id_auth", this.idAuth).list();
            for (Object str : structureList ) {
                courseStructureTOgson = gson.fromJson(String.valueOf(str), CourseStructureTO.class);
                if (courseStructureTOgson.getNameCourse().trim().equals(name.trim())) {
                    return false;
                }
            }

        } catch (Exception ex) {
            new MailUtil().sendErrorMailForAdmin(getClass().getName() + "\n" + Arrays.toString(ex.getStackTrace()));
            logger.error(ex.getStackTrace());
            return false;

        }*/
        return true;
    }

    private boolean addCourse(Session session, String name, String status, int idCategory, String desc) {
        logger.debug(getClass().getName() + " addCourse");

        String dateNow = new SimpleDateFormat(VariablesUtil.PATTERN_DATE).format(new Date().getTime());
        uuidNewCourse = UUID.randomUUID().toString();
        try {
            if (isUniqueNameCourse(name)) {
                CourseEntity courseEntity = new CourseEntity();
                courseEntity.setAuthById(session.load(AuthInfEntity.class, this.idAuth));
                courseEntity.setCategory(idCategory);
                courseEntity.setStatus(status);
                courseEntity.setUuid(uuidNewCourse);
                courseEntity.setStructure(addStructureCourse(this.uuidAuth, name, desc, status, dateNow));
                courseEntity.setNameCourse(name);
                session.save(courseEntity);
                transaction.commit();
                return true;
            } else {
                errorMessage = "A course with this name already exists";
                return false;
            }

        } catch (Exception ex) {
            logger.error(ex.getLocalizedMessage());
            errorMessage = "Course creation failed";
            return false;
        }
    }

    private String addStructureCourse(String uuid_user, String name_course, String description_course, String
            status, String date) {

        return "{\n" +
                "\t\"uuid_user\": \" " + uuid_user + " \",\n" +
                "\t\"name_course\": \" " + name_course + "  \",\n" +
                "\t\"description_course\": \" " + description_course + "  \",\n" +
                "\t\"date_create\": \" " + date + "  \",\n" +
                "\t\"status\": \"" + status + " \",\n" +
                "\t\"section\": [\n" +
                "\t]\n" +
                "}";
    }

    public List<CourseEntity> getUserCourse() {
        logger.debug(getClass().getName() + "getUserCourse");
        session = HibernateUtil.getSessionFactory().openSession();
        session.beginTransaction();
        try {
            return session.createQuery("SELECT c FROM " + VariablesUtil.ENTITY_COURSE + " c WHERE c.authById =: idAuth",
                    CourseEntity.class).setParameter("idAuth", idAuth).getResultList();
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