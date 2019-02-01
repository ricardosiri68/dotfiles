STORE AND LOAD TILIX CONFIG
*backup:*
```dconf dump /com/gexperts/Tilix/ > $HOME/.config/tilix.conf```

*restore:*
```dconf load /com/gexperts/Tilix/ < $HOME/.config/tilix.conf```
