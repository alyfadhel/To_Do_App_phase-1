abstract class AppStates{}

class AppInitialState extends AppStates{}

class InitializeAppState extends AppStates{}

class AppCreateDatabaseState extends AppStates{}

class AppInsertToDatabaseState extends AppStates{}

class AppGetDatabaseLoadingState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class DeleteDatabaseState extends AppStates{}

class ChangeCheckBox extends AppStates{}

class GetDays extends AppStates{}