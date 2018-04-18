package user;

import entity.AuthInfEntity;

import java.util.List;

public interface IParseJsonString {
    String prepareInputString(String login, String password, String emil);

    List<AuthInfEntity> handleInputString(String args);
}
