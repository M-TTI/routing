using System.Windows.Input;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Media;

namespace routing.Views.Components;

public partial class BaseButton : UserControl
{
    public static readonly StyledProperty<string?> LabelProperty =
        AvaloniaProperty.Register<BaseButton, string?>(nameof(Label));

    public static readonly StyledProperty<IImage?> IconProperty =
        AvaloniaProperty.Register<BaseButton, IImage?>(nameof(Icon));

    public static readonly StyledProperty<ICommand?> ActionProperty =
        AvaloniaProperty.Register<BaseButton, ICommand?>(nameof(Action));

    public string? Label
    {
        get => GetValue(LabelProperty);
        set => SetValue(LabelProperty, value);
    }

    public IImage? Icon
    {
        get => GetValue(IconProperty);
        set => SetValue(IconProperty, value);
    }

    public ICommand? Action
    {
        get => GetValue(ActionProperty);
        set => SetValue(ActionProperty, value);
    }
    
    public BaseButton()
    {
        InitializeComponent();
    }
}