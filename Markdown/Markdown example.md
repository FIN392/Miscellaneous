# Markdown _test_ (Título 1)
## Título 2
### Título 3
#### Título 4
##### Título 5
###### Título 6
Texto normal

Enlace a [Lorem ipsum](https://www.lipsum.com/feed/html)

_Itálica_

__Negrita__

___Itálica+Negrita___

~~Tachado~~

Línea

---

Adding an image

![alt text](https://avatars.githubusercontent.com/fin392?size=100 "Me")

Lista:
- Item 1
- Item 2
- Item 3

Lista ordenada:
1. Item 1
2. Item 2
3. Item 3
    * Item 3a
    * Item 3b

Cita:
> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae ligula ex. Mauris nec enim sollicitudin lacus dignissim tincidunt. Sed imperdiet, ante eu commodo pharetra, ante lectus faucibus felis, quis pharetra justo nisl a leo. Sed ullamcorper, ligula vitae eleifend iaculis, tortor dui dignissim mauris, non aliquet lacus tortor ac.

Código
```batch
:: For i=1 to 10 (step 1)...
FOR /L %i IN (1,1,10) DO CALL :Main_FOR_i %i
GOTO Main_ENDFOR_i
:Main_FOR_i

    ECHO Counting 1 to 10: %i

GOTO :EOF
:Main_ENDFOR_i
```

Tabla

| Portal | URL | Centered text | Multi lines text | Numbers |
| --- | --- | :---: | --- | ---: |
| Dropbox | https://www.dropbox.com/ | TRUE | Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi vitae ligula ex. Mauris nec enim sollicitudin lacus dignissim tincidunt. Sed imperdiet, ante eu commodo pharetra, ante lectus faucibus felis, quis pharetra justo nisl a leo. Sed ullamcorper, ligula vitae eleifend iaculis, tortor dui dignissim mauris, non aliquet lacus tortor ac | 123,456.00 |
| GitHub | https://github.com/ | FALSE | N/A | 1.99 |
| Google Drive | https://drive.google.com/ | N/A | N/A | 0.01 |
| OneDrive | http://onedrive.live.com/ | TRUE, but not too much | N/A | 0.00 |
