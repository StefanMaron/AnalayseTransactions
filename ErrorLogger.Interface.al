interface ErrorLogger
{
    /// <summary>
    /// Can not contain any database transactions. Either use temp tables or store in memory.
    /// </summary>
    /// <param name="LastErrorMessage"></param>
    /// <param name="LastErrorCallStack"></param>
    procedure Append(LastErrorMessage: Text; LastErrorCallStack: Text);
    procedure SaveToDatabase();
    procedure IsEmpty(): Boolean;
}