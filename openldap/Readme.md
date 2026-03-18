## Cr√©ation de l'aborescence de ldap

- commande pour appliquer le *ldif* :

    ldapadd -x \
        -H ldap://localhost \
        -D "cn=admin,dc=name,dc=fr" \
        -W \
        -f arborescence.ldif

- V√rifier l'aborescence :

    ldapsearch -x \
        -H ldap://localhost \
        -D "cn=admin,dc=name,dc=fr" \
        -W \
        -b "dc=name,dc=fr" \
        "(objectClass=*)" dn
