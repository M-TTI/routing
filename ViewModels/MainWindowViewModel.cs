using System;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

namespace routing.ViewModels;

public partial class MainWindowViewModel : ObservableObject
{
    public string Greeting { get; } = "Welcome to Avalonia!";

    [RelayCommand]
    public void LogClick()
    {
        Console.WriteLine("Button Clicked");
    }
}
