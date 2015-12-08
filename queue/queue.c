#include <stdio.h>
#include <sys/queue.h>

typedef struct tagPoint1
{
    int x;
    int y;
    LIST_ENTRY(tagPoint1) link;
}Point1;

LIST_HEAD(, tagPoint1) listPoint;
 
void test_list()
{
    Point1 *p;
    Point1 p1, p2, p3; 
    p1.x = p1.y = 10;
    p2.x = p2.y = 20;
    p3.x = p3.y = 30;
    LIST_INIT(&listPoint);
    LIST_INSERT_HEAD(&listPoint, &p1, link); 
    LIST_INSERT_HEAD(&listPoint, &p2, link); 
    LIST_INSERT_HEAD(&listPoint, &p3, link); 
    LIST_FOREACH(p, &listPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
    printf("delete p2\n");
    LIST_REMOVE(&p2, link);
    LIST_FOREACH(p, &listPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
}

typedef struct tagPoint2
{
    int x;
    int y;
    SLIST_ENTRY(tagPoint2) link;
}Point2;

SLIST_HEAD(, tagPoint2) slistPoint;
 
void test_slist()
{
    Point2 *p;
    Point2 p1, p2, p3; 
    p1.x = p1.y = 10;
    p2.x = p2.y = 20;
    p3.x = p3.y = 30;
    SLIST_INIT(&slistPoint);
    SLIST_INSERT_HEAD(&slistPoint, &p1, link); 
    SLIST_INSERT_HEAD(&slistPoint, &p2, link); 
    SLIST_INSERT_HEAD(&slistPoint, &p3, link); 
    SLIST_FOREACH(p, &slistPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
    printf("delete p2\n");
    SLIST_REMOVE(&slistPoint, &p2, tagPoint2, link);
    SLIST_FOREACH(p, &slistPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
}

typedef struct tagPoint3
{
    int x;
    int y;
    STAILQ_ENTRY(tagPoint3) link;
}Point3;

STAILQ_HEAD(, tagPoint3) stailqPoint;
 
void test_stailq()
{
    Point3 *p;
    Point3 p1, p2, p3; 
    p1.x = p1.y = 10;
    p2.x = p2.y = 20;
    p3.x = p3.y = 30;
    STAILQ_INIT(&stailqPoint);
    STAILQ_INSERT_HEAD(&stailqPoint, &p1, link); 
    STAILQ_INSERT_HEAD(&stailqPoint, &p2, link); 
    STAILQ_INSERT_TAIL(&stailqPoint, &p3, link); 
    STAILQ_FOREACH(p, &stailqPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
    printf("delete p2\n");
    STAILQ_REMOVE(&stailqPoint, &p2, tagPoint3, link);
    STAILQ_FOREACH(p, &stailqPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
}

typedef struct tagPoint4
{
    int x;
    int y;
    TAILQ_ENTRY(tagPoint4) link;
}Point4;

TAILQ_HEAD(, tagPoint4) tailqPoint;
 
void test_tailq()
{
    Point4 *p;
    Point4 p1, p2, p3; 
    p1.x = p1.y = 10;
    p2.x = p2.y = 20;
    p3.x = p3.y = 30;
    TAILQ_INIT(&tailqPoint);
    TAILQ_INSERT_HEAD(&tailqPoint, &p1, link); 
    TAILQ_INSERT_HEAD(&tailqPoint, &p2, link); 
    TAILQ_INSERT_TAIL(&tailqPoint, &p3, link); 
    TAILQ_FOREACH(p, &tailqPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
    printf("delete p2\n");
    TAILQ_REMOVE(&tailqPoint, &p2, link);
    TAILQ_FOREACH(p, &tailqPoint, link)
    {
        printf("x=%d,y=%d\n", p->x, p->y);
    }
}

int main()
{
    printf("********* test list *************\n");
    test_list();
    printf("\n********* test slist *************\n");
    test_slist();
    printf("\n********* test stailq *************\n");
    test_stailq();
    printf("\n********* test tailq *************\n");
    test_tailq();
    return 0;
}
