# DoMoDraw
DoMoDraw is a tool that can convert texts describing a domain model to domain model diagrams automatically.

### Install dependencies
``` bash
npm install -g coffee-script
npm install -g http-server
npm install -g bower
```

### Build and run application
``` bash
cd public
bower install
coffee -c -o js/ src/
cd ..
http-server
```

### Play with it
- This version is just a prototype
- It uses regular expression to extract model information from text. Now it only support the following patterns:
  - Word wrapped by single quote will be interpreted as an **'Entity'**
  - Phrase matching **'EntityA'** is a **'EntityB'** will be interpreted as a *Generalization* link
  - Phrase matching **'EntityA'** has a **'EntityB'** will be interpreted as a *Composition* link
  - Phrase matching **'EntityA'** uses **'EntityB'** will be interpreted as a *Usage* link
